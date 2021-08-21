// Generated by gencpp from file algo/num_stateResponse.msg
// DO NOT EDIT!


#ifndef ALGO_MESSAGE_NUM_STATERESPONSE_H
#define ALGO_MESSAGE_NUM_STATERESPONSE_H


#include <string>
#include <vector>
#include <map>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>


namespace algo
{
template <class ContainerAllocator>
struct num_stateResponse_
{
  typedef num_stateResponse_<ContainerAllocator> Type;

  num_stateResponse_()
    : req(false)  {
    }
  num_stateResponse_(const ContainerAllocator& _alloc)
    : req(false)  {
  (void)_alloc;
    }



   typedef uint8_t _req_type;
  _req_type req;





  typedef boost::shared_ptr< ::algo::num_stateResponse_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::algo::num_stateResponse_<ContainerAllocator> const> ConstPtr;

}; // struct num_stateResponse_

typedef ::algo::num_stateResponse_<std::allocator<void> > num_stateResponse;

typedef boost::shared_ptr< ::algo::num_stateResponse > num_stateResponsePtr;
typedef boost::shared_ptr< ::algo::num_stateResponse const> num_stateResponseConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::algo::num_stateResponse_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::algo::num_stateResponse_<ContainerAllocator> >::stream(s, "", v);
return s;
}


template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator==(const ::algo::num_stateResponse_<ContainerAllocator1> & lhs, const ::algo::num_stateResponse_<ContainerAllocator2> & rhs)
{
  return lhs.req == rhs.req;
}

template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator!=(const ::algo::num_stateResponse_<ContainerAllocator1> & lhs, const ::algo::num_stateResponse_<ContainerAllocator2> & rhs)
{
  return !(lhs == rhs);
}


} // namespace algo

namespace ros
{
namespace message_traits
{





template <class ContainerAllocator>
struct IsFixedSize< ::algo::num_stateResponse_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::algo::num_stateResponse_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::algo::num_stateResponse_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::algo::num_stateResponse_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::algo::num_stateResponse_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::algo::num_stateResponse_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::algo::num_stateResponse_<ContainerAllocator> >
{
  static const char* value()
  {
    return "be3c44e19d0c6b00b25e356c69155e2a";
  }

  static const char* value(const ::algo::num_stateResponse_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0xbe3c44e19d0c6b00ULL;
  static const uint64_t static_value2 = 0xb25e356c69155e2aULL;
};

template<class ContainerAllocator>
struct DataType< ::algo::num_stateResponse_<ContainerAllocator> >
{
  static const char* value()
  {
    return "algo/num_stateResponse";
  }

  static const char* value(const ::algo::num_stateResponse_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::algo::num_stateResponse_<ContainerAllocator> >
{
  static const char* value()
  {
    return "bool req\n"
"\n"
"\n"
"\n"
;
  }

  static const char* value(const ::algo::num_stateResponse_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::algo::num_stateResponse_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.req);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct num_stateResponse_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::algo::num_stateResponse_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::algo::num_stateResponse_<ContainerAllocator>& v)
  {
    s << indent << "req: ";
    Printer<uint8_t>::stream(s, indent + "  ", v.req);
  }
};

} // namespace message_operations
} // namespace ros

#endif // ALGO_MESSAGE_NUM_STATERESPONSE_H